import express from "express"
import prisma from "./common/prisma/init.prisma.js"

const app = express()

app.use(express.json())

app.get(`/list-like-res`, async (req, res, n) => {
    const { res_id } = req.body
    const result = await prisma.like_res.findMany({
        where: {
            restaurent: {
                res_id: res_id * 1
            }
        },
        select: {
            like_res_id: true,
            restaurent: {
                select: { res_name: true }
            },
            users: {
                select: {
                    full_name: true
                }
            }
        }
    })
    res.json({ result })
})

app.get(`/list-like-user`, async (req, res, n) => {
    const { user_id } = req.body
    const result = await prisma.like_res.findMany({
        where: {
            users: {
                user_id: user_id * 1
            }
        },
        select: {
            like_res_id: true,
            users: {
                select: {
                    full_name: true
                }
            },
            restaurent: {
                select: { res_name: true }
            },
        },
    })
    res.json({ result })
})

app.post(`/new-like`, async (req, res, n) => {
    console.log(req.body)
    const { user_id, res_id } = req.body
    const isUser = await prisma.users.findUnique({
        where: {
            user_id: user_id * 1
        }
    })

    if (!isUser) return res.json(`Vui lòng đăng nhập`)

    const isRes = await prisma.restaurent.findUnique({
        where: {
            res_id: res_id * 1
        }
    })
    if (!isRes) return res.json(`Không tìm thấy nhà hàng`)

    const likeTime = await prisma.like_res.findFirst({
        where: {
            res_id: res_id * 1,
            user_id: user_id * 1
        },
    })
    if (!likeTime) {
        await prisma.like_res.create({
            data: {
                res_id: res_id * 1,
                user_id: user_id * 1
            }
        })
        return res.json('Like success')
    } else {
        await prisma.like_res.delete({
            where: {
                like_res_id: likeTime.like_res_id
            }
        })
        return res.json(`WHYYYYY`)
    }

})

app.get(`/list-rate-res`, async (req, res, n) => {
    const { res_id } = req.body
    const result = await prisma.rate_res.findMany({
        where: {
            restaurent: {
                res_id: res_id * 1
            }
        },
        select: {
            rate_res_id: true,
            amount: true,
            restaurent: {
                select: { res_name: true }
            },
            users: {
                select: {
                    full_name: true
                }
            }
        }
    })
    res.json({ result })
})

app.get(`/list-rate-user`, async (req, res, n) => {
    const { user_id } = req.body
    const result = await prisma.like_res.findMany({
        where: {
            users: {
                user_id: user_id * 1
            }
        },
        select: {
            like_res_id: true,
            amount: true,
            users: {
                select: {
                    full_name: true
                }
            },
            restaurent: {
                select: { res_name: true }
            },
        },
    })
    res.json({ result })
})

app.post(`/new-rate`, async (req, res, n) => {
    console.log(req.body)
    const { user_id, res_id, amount } = req.body
    const isUser = await prisma.users.findUnique({
        where: {
            user_id: user_id * 1
        }
    })

    if (!isUser) {
        return res.json(`Vui lòng đăng nhập`)
    }
    const isRes = await prisma.restaurent.findUnique({
        where: {
            res_id: res_id *1
        }
    })

    if (!isRes) {
        return res.json(`Nhà hàng không tồn tại`)
    }
    await prisma.rate_res.create({
        data: {
            res_id: res_id * 1,
            user_id: user_id * 1,
            amount: amount * 1
        }
    })
    return res.json('Rate success')
})
const PORT = 3069
app.listen(PORT, () => {
    console.log(`server port ${PORT}`)
})
